---
name: mermaid-diagrams
description: >
  Use this skill to create a mermaid diagram in a Markdown file.
  IF you are asked to create a diagram such as flowchart,
  swimlanes diagram, sequence diagram, class diagram, state diagram,
  entity relationship diagram, user journey, gantt, pie chart,
  quadrant chart, requirement diagram, use case diagram,
  git graph diagram, c4 diagrm, mindmaps, timeline, zen uml,
  sankey, xy chart, block diagram, packet, kanban, architecture,
  radar, event modeling, tree map, venn, ishikawa, wardley,
  cynefin
---

# Mermaid Diagrams

## Flowchart

### Syntax

- To define a node, use `<variableName>@{shape: <shape>, label: "<label>"}`.
- `<shape>`: One of the following name:
  - `bang`: Bang
  - `browser`: Browser window
  - `bucket`: Object storage bucket
  - `notch-rect`: Represents a card
  - `cloud`: cloud
  - `hourglass`: Represents a collate operaton
  - `bolt`: Communiation link
  - `brace`: Adds a comment
  - `brace-r`: Adds a comment
  - `braces`: Adds a comment
  - `console`: Terminal or console window
  - `lean-r`: Represents input or output
  - `lean-l`: Represents input or output
  - `datastore`: Data flow diagram data store
  - `cyl`: Database storage
  - `diam`: Decision-making step
  - `delay`: Represents a delay
  - `h-cyl`: Direct access storage
  - `lin-cyl`: Disk storage
  - `curv-trap`: Represents a display
  - `div-rect`: Divided process shape
  - `doc`: Represents a document
  - `rounded`: Represents an event
  - `tri`: Extraction process
  - `folder`: Folder or directory
  - `fork`: Fork or join in process flow
  - `win-pane`: Internal storage
  - `f-circ`: Junction point
  - `lin-doc`: Lined document
  - `lin-rect`: Lined process shape
  - `notch-pent`: Loop limit step
  - `flip-tri`: Manual file operation
  - `sl-rect`: Manual input step
  - `trap-t`: Represents a manual task
  - `docs`: Multiple documents
  - `st-rect`: Multiple processes
  - `odd`: Odd shape
  - `flag`: Paper tape
  - `person`: Person (circular head above a rouded body)
  - `hex`: Preparation or condition step
  - `trap-b`: Priority action
  - `rect`: Standard process shape
  - `circle`: Starting point
  - `sm-circ`: Small starting point
  - `dbl-circ`: Represents a stop point
  - `fr-circ`: Stop point
  - `bow-rect`: Stored data
  - `fr-rect`: Subprocess
  - `cross-circ`: Summary
  - `tag-doc`: Tagged document
  - `tag-rect`: Tagged process
  - `stadium`: Terminal point
  - `text`: Text block
- To define a node that is a specific service, program or file type,
  use `<variableName>@{ icon: "<icon-set>:<icon-name>", form: "square", label: "<label>", pos: "t", h: 48}`.
- `<icon-set>`: One of the following names:
  - `logos`: https://github.com/gilbarbara/logos
  - `devicon`: https://github.com/devicons/devicon
  - `thesvg`: https://github.com/glincker/thesvg
  - `thesvg-color`: https://github.com/glincker/thesvg
- Code blocks are defined with the following procedures:
  1. Subgraphs and Nodes
  2. Links
  3. Styling and classes

### Example

```mermaid
---
title: Web app service
---
flowchart LR
  %% Sugraphs and Nodes
  subgraph Services["fas:fa-server Services"]
    apiGateway@{shape: rect, label: "API gateway"}
    authService@{shape: rect, label: "Auth service"}
    orderService@{shape: rect, label: "Order service"}
  end

  subgraph Storage["fas:fa-database Storage"]
    ordersDb@{shape: cyl, label: "Orders DB"}
  end

  subgraph Client["fas:fa-laptop Client"]
    webApp@{shape: rect, label: "Web app"}
    localCache@{shape: cyl, label: "Local cache"}
  end

  %% Links
  apiGateway s1@--> authService
  apiGateway s2@--> orderService
  authService s3@-->|token| webApp
  orderService s4@--> ordersDb
  webApp c1@--> localCache
  webApp c2@--> apiGateway

  %% Styling and classes
  classDef ServiceLink stroke:cyan,stroke-dasharray: 9,5,stroke-dashoffset: 900,animation: dash 25s linear infinite
  class s1,s2,s3,s4 ServiceLink
  classDef ClientLink stroke:magenta,stroke-dasharray: 9,5,stroke-dashoffset: 900,animation: dash 25s linear infinite
  class c1,c2 ClientLink
```

### Reference

https://mermaid.js.org/syntax/flowchart.html
