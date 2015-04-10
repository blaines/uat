UAT::Consul
-----------

Interact with, or simulate, consul using this gem.

# Local Mode

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

# Server Mode (use actual consul server)

Append a locally configured path to the end of the host/port (support for multiple service N/A)

    ```
    {
        "local_mode": false,
        "url": "http://consul-server:8080",
        "protocol": "http",
        "discover_paths": false,
        "append_service_path": "/path/to/append/after/host"
    }
    ```

Discover the pathing information via Consul's Key/Value store:

    ```
    {
        "local_mode": false,
        "url": "http://consul-server:8080",
        "protocol": "http",
        "discover_paths": true,
        "service_metadata_key_value_prefix": "chef/services/",
        "metadata_property_for_path": "root_url_path"
    }
    ```