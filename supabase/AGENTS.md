# Supabase: schema, RLS and scheduled jobs for the single Postgres database.
- migrations/: SQL only, forward-only, one change per file named `YYYYMMDDHHMMSS_<change>.sql`. Never edit an applied one.
- Every table has a primary key, NOT NULL by default, CHECK constraints for invariants and explicit foreign keys.
- RLS on for every table: public read where intended, writes only through the service role.
