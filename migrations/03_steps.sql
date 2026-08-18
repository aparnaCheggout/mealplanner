-- Run this in Supabase SQL Editor to add prep steps to meals.
alter table meals add column if not exists steps text;
