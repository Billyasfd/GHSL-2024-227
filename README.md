# GHSL-2024-227
: The pipeline used workflow_run (a privileged event) and executed a script from an untrusted checkout. Because it ran with a shared cache key, an attacker could write to the cache of the main branch.
