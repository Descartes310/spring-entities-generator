for entry in "."/*
do
	if [ $entry != "./repositories.sh" ]
	then
		str_tmp="$(cut -d '/' -f2 <<<"$entry")"
		object="$(cut -d '.' -f1 <<<"$str_tmp")"
		service="$(cut -d '.' -f1 <<<"$str_tmp")Repository"
		objectLowerCase=`echo "$object" | sed -e 's/./\L&/'`
		filename="../$service.java"
		touch $filename
		echo "$1" >> $filename
		echo -e "\nimport $2.$object;" >> $filename
		echo -e "import org.springframework.data.jpa.repository.JpaRepository;" >> $filename
		echo -e "import org.springframework.stereotype.Repository;" >> $filename
		echo -e "\n@Repository" >> $filename
		echo -e "public interface $service extends JpaRepository<$object, Long> {" >> $filename
		echo -e "\n}" >> $filename
	  	echo "Processing completed !"
	fi
done
