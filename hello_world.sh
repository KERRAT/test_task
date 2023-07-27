#New configuration
echo "
server {
    listen 80 default_server;
    server_name app_server;

    root /usr/share/nginx/html;
    error_log /var/log/nginx/app-server-error.log notice;
    index hello-world.html index.html;
    expires -1;
}
" | sudo tee /etc/nginx/sites-available/app

sudo ln -s /etc/nginx/sites-available/app /etc/nginx/sites-enabled/

sudo mkdir -p /usr/share/nginx/html

sudo chmod -R 755 /usr/share/nginx/html

# Create a new html file
echo "
<!DOCTYPE html>
<html>
    <head>
        <title>Hello World</title>
    </head>
    <body>
         <h1>Hello world</h1>
    </body>
</html>
" | sudo tee /usr/share/nginx/html/hello-world.html


sudo systemctl start nginx.service
