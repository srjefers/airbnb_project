#### How to run it?
Make sure that you already have Python3 installed on your machine.
```bash
python -m venv data_cleaning	
source data_cleaning/bin/activate		# activate the environment for Mac and Linux OR
data_cleaning\Scripts\activate			# activate the environment for Windows
pip install -r requirements.txt
python3 script.py --file_path=./data/AB_NYC_2019.csv --export_path=./data/file.csv
```
