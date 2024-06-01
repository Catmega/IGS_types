
## Container Application Node Type (Abstract)

Abstract node type representing a container application.

| Name | URI | Version | Derived From |
|:---- |:--- |:------- |:------------ |
|  ContainerApplication  |  radon.nodes.abstract.ContainerApplication  | 1.0.0 |  tosca.nodes.Container.Application  |

### Properties

| Name | Required | Type |Default Value | Description |
|:---- |:-------- |:---- |:------------- |:----------- |
| image_namespace | false | string |               | Namespace of the container app it's running |
| image_name | false | string |  | Name of the container app it's running |
| image_version | false | string |  | Version of the container app it's running |
| client_mnt_path | false | string | `storage`'s client_mnt_path | root directory of storage |
| volume_dir | false | string |  `storage`'s name | sub directory of storage for its container app|
| container_data_dir | false | string |   | which data inside its container app needs to be volumed |
### Requirements

| Name | Capability Type | Node Type Constraint | Relationship Type | Occurrences |
|:---- |:--------------- |:-------------------- |:----------------- |:------------|
|  host  |  tosca.capabilities.Compute  |  radon.nodes.abstract.ContainerRuntime  |  tosca.relationships.HostedOn  | [1, 1] |
|  storage  |  tosca.capabilities.Storage  |   | tosca.relationships.ConnectsTo  | [1, 1] |
|  network  |  tosca.capabilities.Endpoint  |   | tosca.relationships.ConnectsTo | [1, 1] |
