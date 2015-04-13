UAT::Discovery
-----------

Interact with, or simulate, discovery using this gem.

# Usage

The behavior for how a client provides the urls for a given named service is determined by how the API was configured.
See below for example configuration hashes for different desired behaviors.

    ```
    config = UAT::Discovery::Configuration.new(config_hash)
    api = UAT::Discovery::API.new(config)

    client = api.new_client
    client.urls_for_service('service_name')
    ```

# Configuration Options

Local Mode

    ```
    {
        "local_mode": true,
        "local_service_urls_keyed_by_service_name": {
            "service1": [
                "url1",
                "url2"
            ]
        }
    }
    ```

Server Mode

    Append a locally configured path to the end of the host/port (support for multiple service N/A)

    ```
    {
        "local_mode": false,
        "url": "http://discovery-server:8080",
        "protocol": "http",
        "discover_paths": false,
        "append_service_path": "/path/to/append/after/host"
    }
    ```

    Discover the pathing information via Discovery's Key/Value store:

    ```
    {
        "local_mode": false,
        "url": "http://discovery-server:8080",
        "protocol": "http",
        "discover_paths": true,
        "service_metadata_key_value_prefix": "chef/services/",
        "metadata_property_for_path": "root_url_path"
    }
    ```