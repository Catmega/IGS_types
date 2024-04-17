![](https://img.shields.io/badge/Status:-RELEASED-green)

## [IGS Component] Repository Node Type 

Node type representing a Repository.

| Name | URI | Version | Derived From |
|:---- |:--- |:------- |:------------ |
| `Repository` | `igs.nodes.Component.Repository` | 1.0.0 | `igs.nodes.abstract.Component` |

### Properties

| Name | Required | Type | Constraint | Default Value | Description |
|:---- |:-------- |:---- |:---------- |:------------- |:----------- |
| `name` | `false` | `string` |   |   | Name of the container runtime |

### Capabilities

| Name | Type | Valid Source Types | Occurrences |
|:---- |:---- |:------------------ |:----------- |
| `host` | `tosca.capabilities.Compute` | `[radon.nodes.abstract.ContainerApplication]` | [1, UNBOUNDED] |
