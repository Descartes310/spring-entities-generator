for entry in "."/*
do
	if [ $entry != "./services.sh" ]
	then
		str_tmp="$(cut -d '/' -f2 <<<"$entry")"
		object="$(cut -d '.' -f1 <<<"$str_tmp")"
		service="$(cut -d '.' -f1 <<<"$str_tmp")Service"
		objectLowerCase=`echo "$object" | sed -e 's/./\L&/'`
		filename="../../services/$service.java"
		touch $filename
		echo "$1" >> $filename
		echo -e "\nimport $2.$object;" >> $filename
		echo -e "import java.util.List;" >> $filename
		echo -e "\npublic interface $service {" >> $filename
		echo -e "\n\t// To save a $object to database\n\t$object save($object $objectLowerCase);" >> $filename
		echo -e "\n\t// To get all $object's entries from database\n\tList<$object> findAll();" >> $filename
		echo -e "\n\t// To find $object from database using its identifier\n\t$object getOne(Long id);" >> $filename
		echo -e "\n\t// To delete $object from database using its identifier\n\tvoid delete(Long id);" >> $filename
		echo -e "\n}" >> $filename
	  	echo "Processing completed !"
	fi
done
