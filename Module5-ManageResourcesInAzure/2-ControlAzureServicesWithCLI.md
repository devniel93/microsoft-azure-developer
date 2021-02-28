# Control de los servicios de Azure con la CLI

## _¿Qué es la CLI de Azure?_
Es un programa de línea de comandos para conectarse a Azure y ejecutar comandos administrativos en recursos de Azure. Se ejecuta en Linux, macOS y Windows y permite que los administradores y desarrolladores ejecuten sus comandos a través del símbolo del sistema

### Instalación de la CLI de Azure
En Linux y macOS, use un administrador de paquetes para instalar la CLI de Azure.
- Linux: apt-get en Ubuntu, yum en Red Hat y zypper en OpenSUSE
- Mac: Homebrew
- En Windows: instale la CLI de Azure mediante la descarga y ejecución de un archivo MSI.

## _¿Qué recursos de Azure se pueden administrar mediante la CLI de Azure?_
Permite controlar casi todos los aspectos de cualquier recurso de Azure. Puede trabajar con grupos de recursos, almacenamiento, máquinas virtuales, Azure Active Directory (Azure AD), contenedores, aprendizaje automático, etc.

¿Cómo puede encontrar los comandos específicos que necesita? Una forma de hacerlo es usar `az find`.

Si ya conoce el nombre del comando que quiere, el argumento `--help` para ese comando obtendrá información más detallada sobre el comando y, para un grupo de comandos, una lista de los subcomandos disponibles.