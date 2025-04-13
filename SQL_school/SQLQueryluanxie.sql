--use School
--if exists(select name from sysindexes where name='IDX_tno')
--	drop index Teacher.IDX_tno
--	GO
--	create index IDX_tno ON Teacher(±àºÅ)
--	GO

--if exists(select name from sysindexes where name='IDX_bhname')
--	drop index Score.IDX_bhname
--	GO
--	create unique nonclustered index IDX_bhname ON Student(°àºÅ,ÐÕÃû)
--	GO

if exists(select name from sysindexes where name='IDX_bhname')
	drop index Student.IDX_bhname
	GO
	create index IDX_bhname ON Student(°àºÅ,ÐÕÃû)
	with (pad_index=on ,fillfactor=80)
	GO