# Protección de los recursos de Azure con el control de acceso basado en roles de Azure (Azure RBAC)
El control de acceso basado en rol de Azure (Azure RBAC) es un sistema de autorización de Azure que ayuda a administrar quién tiene acceso a los recursos de Azure, qué puede hacer con esos recursos y a qué áreas puede acceder.

## _Suscripciones de Azure_
Cada suscripción de Azure está asociada a un único directorio de Azure AD.  Los usuarios, grupos y aplicaciones de ese directorio pueden administrar los recursos en la suscripción de Azure. Las suscripciones usan Azure AD para el inicio de sesión único (SSO) y para la administración de acceso. Puede extender su instancia de Active Directory local a la nube con Azure AD Connect.

## _¿Qué es el control de acceso basado en rol de Azure?_
Se puede conceder acceso al asignar el rol de Azure adecuado a usuarios, grupos y aplicaciones de un determinado ámbito. El ámbito de una asignación de roles puede ser una suscripción, un grupo de recursos o un único recurso. Un rol asignado en un ámbito principal también concede acceso a los ámbitos secundarios dentro del mismo. 

### ¿Qué puedo hacer con Azure RBAC?
- Permitir que un usuario administre las máquinas virtuales de una suscripción y que otro usuario administre las redes virtuales
- Permiso a un grupo de administradores de base de datos para administrar bases de datos SQL en una suscripción
- Permitir que un usuario administre todos los recursos de un grupo de recursos, como las máquinas virtuales, los sitios web y las subredes
- Permitir que una aplicación acceda a todos los recursos de un grupo de recursos

### Azure RBAC en Azure Portal
En varias áreas de Azure Portal, verá un panel denominado Control de acceso (IAM), también conocido como administración de identidad y acceso. En este panel puede ver quién tiene acceso a dicha área y su rol.

## _¿Cómo funciona Azure RBAC?_
El acceso a los recursos se controla mediante Azure RBAC mediante la creación de asignaciones de roles.  Para crear una asignación de roles, se necesitan tres elementos: una entidad de seguridad, una definición de roles y un ámbito. ("quién", "qué" y "dónde")

1. Entidad de seguridad (quién): es simplemente un nombre para un usuario, un grupo o una aplicación a los que quiere conceder acceso.

2. Definición de roles (lo que puede hacer): es una recopilación de permisos. Una definición de roles enumera los permisos que se pueden realizar, por ejemplo, de lectura, escritura y eliminación. Azure incluye varios roles integrados que se puede usar:
- Propietario: tiene acceso total a todos los recursos, incluido el derecho a delegar este acceso a otros.
- Colaborador: puede crear y administrar todos los tipos de recursos de Azure pero no puede conceder acceso a otros.
- Lector: puede ver los recursos existentes de Azure.
- Administrador de acceso de usuario: permite administrar el acceso de los usuarios a los recursos de Azure.

3. Ámbito (dónde)
El ámbito es donde se aplica el acceso. Esto resulta útil si desea convertir a alguien en colaborador del sitio web, pero solo para un grupo de recursos.  puede especificar un ámbito en varios niveles: grupo de administración, suscripción, grupo de recursos o recurso. Los ámbitos se estructuran en una relación de elementos primarios y secundarios. Si otorga acceso a un ámbito primario, esos permisos se heredan en los ámbitos secundarios.

