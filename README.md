# 🚀 Suite de Pruebas Automatizadas - API ServeRest (Karate DSL)

Proyecto de automatización de pruebas BackEnd para la API de gestión de usuarios de [ServeRest](https://serverest.dev/) desarrollado con **Karate DSL** y **JUnit 5**.

---

## 📋 1. Estrategia de Automatización y Patrones Utilizados

Como parte de los estándares de calidad de ingeniería de software (ISTQB & QE Practices), se implementó:

### A. Patrones y Buenas Prácticas
1. **Dynamic Test Data Generation:** Se implementó una función centralizada en `karate-config.js` (`getRandomUser()`) que genera datos únicos (nombres, correos irrepetibles con UUIDs y timestamps) en cada petición, evitando colisiones de emails duplicados (error 400).
2. **Schema & Contract Testing (Fuzzy Matchers):** Validación estructural de contratos JSON (tipos de datos `#string`, `#number`, `#regex`) para garantizar la integridad ante cambios en el backend.
3. **Flujo E2E (End-to-End):** Implementación de una prueba integral de ciclo de vida completo (Create -> Read -> Update -> Delete -> Verify Deletion).
4. **Independencia y Atomicidad:** Cada escenario es autónomo y no depende del estado previo de la base de datos.

### B. Cobertura de Pruebas (13 Escenarios - 100% Passed)
* **GET /usuarios:** Listado general, filtrado por query params y validación de contrato JSON.
* **POST /usuarios:** Creación exitosa (201), manejo de duplicados (400) y validación de campos obligatorios faltantes (400).
* **GET /usuarios/{_id}:** Búsqueda por ID existente (200) e inexistente (400).
* **PUT /usuarios/{_id}:** Actualización exitosa (200), creación upsert (201) y conflicto de email duplicado (400).
* **DELETE /usuarios/{_id}:** Eliminación exitosa (200) e idempotencia ante IDs no existentes (200).
* **Flujo E2E:** Ciclo de vida completo del recurso usuario.

---

## 🛠️ 2. Prerrequisitos
* **Java JDK:** Versión 17.
* **Apache Maven:** Versión 3.8+.

---

## 🏃 3. Instrucciones de Ejecución

Ejecutar toda la suite desde la terminal:
```bash
mvn clean test
