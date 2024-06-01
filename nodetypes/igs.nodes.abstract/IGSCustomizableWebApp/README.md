
## Customizable WebApp Node Type (Abstract)

Abstract node type representing a customizable container web application.

<!-- To explain in more detail, this node type is intended to build a complete and deploy-able container image.

An artifact of software-solution (e.g. app.jar, index.html, or a folder of frontend project) should be attached to this node in the service template. And assign the tech stack topology: assign the web app server, the runtime, the os. 

This node's implementation(Standard's create) will prepare the undelying environment for this application in a image. It will install and configure the OS, the runtime, the web app server, and will deploy the artifact upon the web app server. In the end everything will be packaged into a reusable image. -->

| Name | URI | Version | Derived From |
|:---- |:--- |:------- |:------------ |
|  CustomizableWebApp  |  igs.nodes.abstract  | 1.0.0 |  igs.nodes.abstract.ContainerApplication  |

### Properties

| Name | Inhrited | Required | Type |Default Value | Description |
|:---- |:--------|:-------- |:---- |:------------- |:----------- |
| image_namespace| ✓ | false | string |               | Namespace of the container app it's running |
| image_name | ✓| false | string |  | Name of the container app it's running |
| image_version| ✓ | false | string |  | Version of the container app it's running |
| client_mnt_path| ✓ | false | string | `storage`'s client_mnt_path  | root directory of storage |
| volume_dir| ✓ | false | string | `storage`'s name  | sub directory of storage for its container app|
| container_data_dir| ✓ | false | string |   | which data inside its container app needs to be volumed |
| app_file_loc | ✕ | true | string | notGiven  | artifact location |
| base_webapp_server_name | ✕ | true | string | `webAppServer`'s base_webapp_server_name  | the name of the web app server this app is based on |
| base_webapp_server_version | ✕ | true | string |  `webAppServer`'s base_webapp_server_version | the version of the web app server this app is based on |
### Requirements

| Name| Inhrited  | Capability Type | Node Type Constraint | Relationship Type | Occurrences |
|:---- |:----|:--------------- |:-------------------- |:----------------- |:------------|
|  host | ✓ |  tosca.capabilities.Compute  |  radon.nodes.abstract.ContainerRuntime  |  tosca.relationships.HostedOn  | [1, 1] |
|  storage | ✓ |  tosca.capabilities.Storage  |   | tosca.relationships.ConnectsTo  | [1, 1] |
|  network | ✓ |  tosca.capabilities.Endpoint  |   | tosca.relationships.ConnectsTo | [1, 1] |
|  webAppServer | ✓ |  igs.capabilities.WebAppServer  |  igs.nodes.abstract.WebAppServer | tosca.relationships.HostedOn | [1, 1] |
### Implementation

| Operation | Interface | description |
|:---- |:--------------- |:-------------------- |
| create | Standard | creating a deploy-able container application (in the docker image format) using the artifact given in `app_file_loc` | tosca.relationships.DependsOn | [0, 1] |