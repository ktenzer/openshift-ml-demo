var express = require('express');   //Express Web Server 
var bodyParser = require('body-parser'); //connects bodyParsing middleware
var formidable = require('formidable');
var path = require('path');     //used for file path
var mv = require('mv');
var cmd=require('node-cmd');

var app = express();
app.use(express.static(path.join(__dirname, 'static')));

/* ========================================================== 
 bodyParser() required to allow Express to see the uploaded files
============================================================ */
app.use(bodyParser.urlencoded({
  extended: true
}));

//display results
function display_stdout(res) {

  res.setHeader("Content-Type", "text/html; charset=utf-8");
  res.write('<html>');
  res.write('<head><meta name="viewport" content="initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" charset="UTF-8"><title>Machine Learning Demo App</title></head>');
  res.write('<body>');
  res.write('<h1> Translated Results </h1>')
  res.write('<form action="/refresh" method = "post">');
  res.write('<button>Refresh</button>');
  res.write('</form>');
  res.write('<form action="/" method = "post">');
  res.write('<button>Home</button>');
  res.write('</form>');


  var spawn = require('child_process').spawn;
  var command = spawn('cat', ['/tmp/output.txt']);
  var result = '';
  command.stdout.on('data', function(data) {
    result += data.toString();
    res.write('<h4>' + result + '</h4>');
  });
    command.on('close', function(code) {
      res.end();
  });
  console.log(result);
}

//home route
app.route('/')
  .post(function (req, res, next) {
  res.redirect('/');
});

//refresh the results page route
app.route('/refresh')
  .post(function (req, res, next) {
  display_stdout(res);
});

//Initial results page route
app.route('/results')
  .post(function (req, res, next) {
  display_stdout(res);
});

//upload wav file and decode/translate using python route
app.route('/upload')
  .post(function (req, res, next) {

  var form = new formidable.IncomingForm();
    //Formidable uploads to operating systems tmp dir by default
    //form.uploadDir = "./img";       //set upload directory
    form.keepExtensions = true;     //keep file extension

    form.parse(req, function(err, fields, files) {
      console.log("form.bytesReceived");

      if (err)
        throw err;

        // Debug
        console.log("Selected language " + fields.optradio);
        console.log("file size: "+JSON.stringify(files.fileUploaded.size));
        console.log("file path: "+JSON.stringify(files.fileUploaded.path));
        console.log("file name: "+JSON.stringify(files.fileUploaded.name));
        console.log("file type: "+JSON.stringify(files.fileUploaded.type));
        console.log("lastModifiedDate: "+JSON.stringify(files.fileUploaded.lastModifiedDate));

        //move file from temp location
        mv(files.fileUploaded.path, '/app/'+files.fileUploaded.name, function(err) {
        console.log('file uploaded and renamed');  

        //execute python voice recognition and translation program
        var python_cmd = 'python3 translate.py --slang en --tlang ' + fields.optradio + ' --file /app/' + files.fileUploaded.name + ' --models /deepspeech/models'
        cmd.get(python_cmd, 
          function(err, data, stderr) {
            if (!err) {
              console.log(python_cmd + ' succeeded:',data)
            } else {
              console.log(python_cmd + ' failed!', err)
            }
          }
        );
      });

      res.redirect('/');
    });
});

//start http listener
var server = app.listen(8080, function() {
console.log('Listening on port %d', server.address().port);
});
