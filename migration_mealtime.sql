-- Run this in Supabase SQL Editor to switch meals from Family/Personal to Breakfast/Lunch/Dinner.
-- Safe to run even if you haven't added real meals yet.

alter table meals drop constraint if exists meals_type_check;
alter table meals add constraint meals_type_check check (type in ('breakfast', 'lunch', 'dinner'));

-- Clear any existing schedule built under the old family/personal slots,
-- since the day structure has changed (schedule is stored as flexible jsonb, no column changes needed).
delete from plans;
