USE $(db_name);
GO
BACKUP DATABASE $(db_name)
TO DISK = '$(full_path)'
   WITH 
      MEDIANAME = 'Z_SQLServerBackups',
	  NOINIT, SKIP, NOREWIND, STATS = 10,
      NAME = $(backup_name);
GO