## About
References for this project: [https://github.com/frappe/frappe_docker](https://github.com/frappe/frappe_docker)

## Configuration

### `FRAAPE_GIT`

Frappe framework repository url, default : [https://github.com/frappe/frappe.git](https://github.com/frappe/frappe.git)

### `ERPNEXT_GIT`

ERPNext repository url, default : [https://github.com/frappe/erpnext.git](https://github.com/frappe/erpnext.git)

### `FRAPPE_BRANCH`

Frappe framework branch. You can find all branch [here](https://github.com/frappe/frappe). default: version-13

### `ERPNEXT_BRANCH`

Frappe framework branch. You can find all branch [here](https://github.com/frappe/erpnext). default: version-13

### `DOMAIN`

Site's name, this environment variable is required. default: erp.example.com

### `DB_TYPE`

Database type. default : mariadb

### `DB_HOST`

Hostname for MariaDB (or Postgres) database. Set only if external service for database is used.

### `DB_PASSWORD`

Password for MariaDB (or Postgres) database.