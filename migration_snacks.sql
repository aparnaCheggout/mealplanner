-- Run this in Supabase SQL Editor to add a 4th meal-time category: Snacks.
alter table meals drop constraint if exists meals_type_check;
alter table meals add constraint meals_type_check check (type in ('breakfast', 'lunch', 'dinner', 'snacks'));
