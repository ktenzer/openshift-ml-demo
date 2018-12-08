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

app.post('/results', function (req, res) {
  function display_stdout(callback) {
    var spawn = require('child_process').spawn;
    var command = spawn('cat', ['/tmp/output.txt']);
    var result = '';
    command.stdout.on('data', function(data) {
      result += data.toString();
    });
      command.on('close', function(code) {
      return callback(result);
    });
    console.log(result);
  }
  display_stdout(function(result) { res.send(result) });
});

app.route('/upload')
 .post(function (req, res, next) {

  var form = new formidable.IncomingForm();
    //Formidable uploads to operating systems tmp dir by default
    //form.uploadDir = "./img";       //set upload directory
    form.keepExtensions = true;     //keep file extension

    form.parse(req, function(err, fields, files) {
        console.log("form.bytesReceived");

        // Debug
        //console.log("file size: "+JSON.stringify(files.fileUploaded.size));
        //console.log("file path: "+JSON.stringify(files.fileUploaded.path));
        //console.log("file name: "+JSON.stringify(files.fileUploaded.name));
        //console.log("file type: "+JSON.stringify(files.fileUploaded.type));
        //console.log("lastModifiedDate: "+JSON.stringify(files.fileUploaded.lastModifiedDate));

        //mv(files.fileUploaded.path, '/app/'+files.fileUploaded.name, function(err) {

        if (err)
            throw err;

          // Debug
          console.log("file size: "+JSON.stringify(files.fileUploaded.size));
          console.log("file path: "+JSON.stringify(files.fileUploaded.path));
          console.log("file name: "+JSON.stringify(files.fileUploaded.name));
          console.log("file type: "+JSON.stringify(files.fileUploaded.type));
          console.log("lastModifiedDate: "+JSON.stringify(files.fileUploaded.lastModifiedDate));

          mv(files.fileUploaded.path, '/app/'+files.fileUploaded.name, function(err) {
          console.log('file uploaded and renamed');  

          var python_cmd = 'python2 translate.py --slang en --tlang de --file /app/' + files.fileUploaded.name + ' --models /deepspeech/models'
          cmd.run(python_cmd);
        });

        res.redirect('/');

    });
});

var server = app.listen(8080, function() {
console.log('Listening on port %d', server.address().port);
});
