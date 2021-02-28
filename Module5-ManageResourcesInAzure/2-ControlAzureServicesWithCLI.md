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

---

## _Creación de un sitio web de Azure mediante la CLI_
1. Crear variables para comandos posteriores:
```
export RESOURCE_GROUP=learn-915b1964-77f4-4a80-9b77-73b1bef37a7e
export AZURE_REGION=centralus
export AZURE_APP_PLAN=popupappplan-$RANDOM
export AZURE_WEB_APP=popupwebapp-$RANDOM
```
2. Consultar los grupos de recursos en una tabla
```
az group list --output table
```

3. Si se tiene varios elementos en la lista de grupos, puede filtrar los valores devueltos agregando una opción `--query`
```
az group list --query "[?name == '$RESOURCE_GROUP']"
```
Para este formato de consulta se establece con el lenguaje _JMESPath_

4. Crear plan de servicio
```
az appservice plan create --name $AZURE_APP_PLAN --resource-group $RESOURCE_GROUP --location $AZURE_REGION --sku FREE
```

5. Comprobar el plan creado 
```
az appservice plan list --output table
```

6. Crear web app
```
az webapp create --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --plan $AZURE_APP_PLAN
```

7. Comprobar que se haya creado la web app
```
az webapp list --output table
```

El valor de _DefaultHostName_ es la URL para el nuevo sitio web implementado.
popupwebapp-25085.azurewebsites.net

8. Pasos para implementar código desde GitHub
Ejecutar lo siguiente 

```
az webapp deployment source config --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --repo-url "https://github.com/Azure-Samples/php-docs-hello-world" --branch master --manual-integration
```

9. Comprobar con explorador o CURL
```
curl $AZURE_WEB_APP.azurewebsites.net
```