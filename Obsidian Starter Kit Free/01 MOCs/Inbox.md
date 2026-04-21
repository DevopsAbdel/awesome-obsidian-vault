
>[!info]
>An Inbox in note-taking and note-making serves as a central repository for capturing fleeting notes, thoughts, and ideas as they occur. Utilising the [[zettelkasten-workflow.png|Zettelkasten Workflow]], it ensures that all initial, unprocessed information is stored in a designated area, often referred to as the "[[00 Notelab]]." 
>
>From here, these notes can be systematically organised into more permanent and structured categories such as [[+ About Cards ℹ️| 02 Cards]], which contain actionable items; [[+ About Spaces ℹ️| 03 Spaces]], dedicated to ongoing Explorations; and [[+ About Vaults ℹ️| Vaults]], which archive valuable information for long-term reference. This approach streamlines the note-taking process, promoting efficiency and clarity in managing one's ideas and information.

>[!hint] To create our Inbox we need to install a Community Plugin called Dataview
>- https://blacksmithgu.github.io/obsidian-dataview/
> - The Starter Vault will have this Plugin already installed

>[!example]+ Table of Contents
>- [[#Notelab|Notelab]]
>- [[#Cards|Cards]]
>- [[#Spaces|Spaces]]
>- [[#Vault|Vault]]

Our Dataview Query will look as follows

```markdown
TABLE WITHOUT ID
 file.link as "List from NoteLab",
 (date(today) - file.cday).day as "Days alive"

FROM "00 NoteLab" and -#🌱 

SORT file.cday DESC

LIMIT 40
```

### NoteLab
``` dataview
TABLE WITHOUT ID
 file.link as "List from NoteLab",
 (date(today) - file.cday).day as "Days alive"

FROM "00 NoteLab" and -#🌱 

SORT file.cday DESC

LIMIT 40
```

### Cards
``` dataview
TABLE WITHOUT ID
 file.link as "List from Cards",
 (date(today) - file.cday).day as "Days alive"

FROM "02 Cards"

SORT file.cday DESC

LIMIT 40
```

### Spaces
``` dataview
TABLE WITHOUT ID
 file.link as "List from Spaces",
 (date(today) - file.cday).day as "Days alive"

FROM "03 Spaces"

SORT file.cday DESC

LIMIT 40
```

###  Vault
``` dataview
TABLE WITHOUT ID
 file.link as "List from Vault",
 (date(today) - file.cday).day as "Days alive"

FROM "04 VAULT"

SORT file.cday DESC

LIMIT 40
```