
https://www.nuget.org/

## 

Install-Package Microsoft.EntityFrameworkCore -Version 3.0.1


Install-Package EntityFrameworkCore.BootKit -Version 1.15.0


**Microsoft.EntityFrameworkCore.Design** contains all the design-time logic for Entity Framework Core. It's the code that all of the various tools (PMC cmdlets like Add-Migration, dotnet ef & ef.exe) call into.

If you don't use Migrations or Reverse Engineering, you don't need it.

And when you do need it, we encourage PrivateAssets="All" so it doesn't get published to the server where you almost certainly won't need it.


## Referências
- https://www.learnentityframeworkcore.com/efcore/how-to-get
- https://www.entityframeworktutorial.net/efcore/install-entity-framework-core.aspx
- https://www.entityframeworktutorial.net/efcore/entity-framework-core-migration.aspx