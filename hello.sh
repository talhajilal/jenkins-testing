#/bin/bash
echo "Hello World"


backup_dir=/opt/backup_dir
main() {
  echo "this shouldn't run"
  {
  echo "this shouldn't run either"
}

create_dir() {
    mkdir -p $backup_dir
    mkdir -p $backup_dir/sql_backup
}
copy_webfile(){
    cp -R /moodledata/cache  $backup_dir/.
    cp -R /moodledata/localcache $backup_dir/.
    cp -R /moodledata/sessions $backup_dir/.
    cp -R /moodledata/temp $backup_dir/.
    cp -R /moodledata/trashdir $backup_dir/.
}

main(){
    create_dir
    copy_webfile
}
main

