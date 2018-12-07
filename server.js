var http = require('http');
var formidable = require('formidable');
var fs = require('fs');

http.createServer(function (req, res) {
  if (req.url == '/fileupload') {
    var form = new formidable.IncomingForm();
    form.parse(req, function (err, fields, files) {
      var oldpath = files.filetoupload.path;
      var newpath = '/app/' + files.filetoupload.name;
      fs.rename(oldpath, newpath, function (err) {
        if (err) throw err;
        res.write('File uploaded and moved!');
        res.end();
        function runSingleCommandWithWait() {
          Promise.coroutine(function *() {
            var response = yield cmd.run('node --version');
            if(response.success) {
              // do something
              // if success get stdout info in message. like response.message
            } else {
              // do something
              // if not success get error message and stdErr info as error and stdErr. 
              //like response.error and response.stdErr
            }
            console.log('Executed your command :)');
          })();
        }
      });
 });
  } else {
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.write('<form action="fileupload" method="post" enctype="multipart/form-data">');
    res.write('<input type="file" name="filetoupload"><br>');
    res.write('<input type="submit">');
    res.write('</form>');
    return res.end();
  }
}).listen(8080);
