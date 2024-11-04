# Scripts de Base de Datos del Proyecto Final

## Descripción del Proyecto

Este repositorio contiene scripts para la creación y manipulación de la base de datos utilizada en el proyecto final. La base de datos está diseñada para almacenar información relacionada con empleados, contratos, desempeño y salud mental en un contexto empresarial.

## Estructura de la Base de Datos

La base de datos está modelada en Postgres y se compone de las siguientes entidades:

1. **Empleado**
   - `empleado_id`: Identificador único del empleado.
   - `nombres`: Nombres del empleado.
   - `apellidos`: Apellidos del empleado.
   - `fecha_nacimiento`: Fecha de nacimiento del empleado.
   - `genero`: Género del empleado.
   - `anios_experiencia`: Años de experiencia laboral.
   - `rating_equilibrio_vida_laboral`: Evaluación del equilibrio entre vida laboral y personal.
   - `num_reuniones_virtuales`: Número de reuniones virtuales realizadas.
   - `horas_trabajadas_por_semana`: Horas trabajadas por semana.

2. **Empresa**
   - `empresa_id`: Identificador único de la empresa.
   - `nombre`: Nombre de la empresa.
   - `industria`: Industria a la que pertenece la empresa.

3. **Contrato**
   - `empleado_id`: Identificador del empleado (relación con la colección Empleado).
   - `periodo`: Periodo de trabajo.
   - `puesto_trabajo`: Puesto desempeñado en la empresa.
   - `modalidad_trabajo`: Modalidad de trabajo (presencial, remoto, híbrido).
   - `empresa_id`: Identificador de la empresa (relación con la colección Empresa).

4. **EDesempenio**
   - `codigo`: Identificador único del desempeño.
   - `productividad_impacto`: Impacto en la productividad.
   - `satisfaccion_trabajo`: Nivel de satisfacción laboral.
   - `empleado_id`: Identificador del empleado (relación con la colección Empleado).
   - `periodo`: Periodo evaluado.

5. **SaludMental**
   - `codigo`: Identificador único de salud mental.
   - `rating_aislamiento_social`: Evaluación del aislamiento social.
   - `freq_actividad_fisica`: Frecuencia de actividad física.
   - `calidad_suenio`: Calidad del sueño.
   - `nivel_estres`: Nivel de estrés.
   - `diagnostico`: Diagnóstico de salud mental.
   - `empleado_id`: Identificador del empleado (relación con la colección Empleado).
   - `periodo`: Periodo evaluado.

## Backups 
En la carpeta `backups` se encuentran las bases de datos utilizadas para las pruebas de optimización. Cada archivo está nombrado según el volumen de registros insertados: `100`, `1 000`, `10 000` y `100 000`.

Para restaurar cualquiera de estas bases de datos, utiliza el siguiente comando, ajustando el nombre de la base de datos y la ubicación del archivo dump:

```
psql -U postgres -h localhost -d nombre-de-la-bd -f ubicacion-archivo-dump
```

## Integrantes del Proyecto

- **Robert Junior Buleje del Carpio**
- **Diana Sanchez Ordóñez**