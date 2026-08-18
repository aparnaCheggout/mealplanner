-- Run this in Supabase SQL Editor to switch meals from Family/Personal to Breakfast/Lunch/Dinner.

-- Remap any existing meals from the old categories instead of losing them:
-- family dinners become "dinner", personal prep meals become "lunch".
-- Edit these two lines first if you'd rather remap them differently (e.g. to 'breakfast').
update meals set type = 'dinner' where type = 'family';
update meals set type = 'lunch' where type = 'personal';

alter table meals drop constraint if exists meals_type_check;
alter table meals add constraint meals_type_check check (type in ('breakfast', 'lunch', 'dinner'));

-- Clear any existing schedule built under the old family/personal slots,
-- since the day structure has changed (schedule is stored as flexible jsonb, no column changes needed).
delete from plans;
