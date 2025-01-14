Steps to Use the Plugin
Install the Plugin: Run 
sudo luarocks make kong-plugin-encode-plugin-0.1.0-1.rockspec
Enable the Plugin:
Add the plugin to a service or globally using the Admin API.





Example:

curl -X POST http://localhost:8001/services/{service_id}/plugins \
     --data "name=encode-plugin"
Test the Plugin: Verify with requests to ensure the responses are encoded.
This setup ensures the backend response is Base64 encoded while conforming to Kong's plugin framework.
