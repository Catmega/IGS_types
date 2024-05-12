
## IGS Component Node Type (Abstract)

Abstract node type representing IG Service Components.

| Name | URI | Derived From |
|:---- |:--- |:------------ |
| Component | igs.nodes.abstrac` | tosca.nodes.Root |

### Properties

| Name | Required | Type | Default Value | Description |
|:---- |:-------- |:---- |:----------  |:----------- |
| service_name | false | string | undefinedname  | name of IG service component |
| image_namespace | false | string | `containerApplication`'s image_namespace  | Namespace of the container app it's running |
| image_name | false | string | `containerApplication`'s image_name  | Name of the container app it's running |
| image_version | false | string | `containerApplication`'s image_version  | Version of the container app it's running |
| stack_name | false | string | undefined  | identifier of which set of deployment this Component belongs to |
| labels | false | string | undefined  | labels indicating which host machine it should runing on|
| client_mnt_path | false | string | `containerApplication`'s client_mnt_path  | root directory of storage |
| volume_dir | false | string |  `containerApplication`'s volume_dir | sub directory of storage for its container app|
| container_data_dir | false | string |  `containerApplication`'s container_data_dir | which data inside its container app needs to be volumed |
| replica_num | false | integer | 1  | how many replicas of container app should running in this IGS componennt |
| docker_compose_file_loc | false | string |  notGiven | location of the artifact defining how to run this component on certain platform |

### Requirements

| Name | Capability Type | Node Type Constraint | Relationship Type | Occurrences |
|:---- |:--------------- |:-------------------- |:----------------- |:------------|
| containerApplication | tosca.capabilities.Container | igs.nodes.abstract.ContainerApplication  | tosca.relationships.DependsOn | [0, 1] |

### Implementation

| Operation | Interface | description |
|:---- |:--------------- |:-------------------- |
| start | Standard | starting this IGS component directly using the artifact given in `docker_compose_file_loc` | tosca.relationships.DependsOn |