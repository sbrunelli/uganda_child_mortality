import pandas as pd
import numpy as np
import psycopg2

class DataPreparation(object):

    def __init__(self, train_test_split_frac=0.8):
        self._data = None
        self._train_test_split_frac = train_test_split_frac
        self._integer_features = ['died']
        # self._numeric_features = ['years_lived_village']
        self._numeric_features = ['qn1009_hhw', 'totalshops_village', 'mchildren2008_village']
        # self._categorical_features = ['parish_name'
        #  	 ,'qn204_know', 'qn209b_know', 'qn210_know', 'qn211a_know', 'qn211b_know'
        #  	 ,'qn212_know', 'qn216_know', 'qn217_know', 'qn1002_hhw', 'shop_village'
        #      ]
        self._categorical_features = ['parish_name', 'qn204_know', 'qn209b_know', 'qn210_know', 'qn211a_know', 'qn211b_know',
        'qn211c_know', 'qn216_know', 'qn217_know', 'qn302c_mal', 'qn303c_mal', 'qn304c_mal',
        'qn320c_mal', 'qn502c_dia', 'qn503c_dia', 'qn505ca_dia', 'qn505cb_dia', 'qn506cb_dia',
        'qn507c_dia', 'qn510c_dia', 'qn512c_dia', 'qn603c_fort', 'qn606c_fort', 'qn706a_chp',
        'qn708_chp', 'qn727_chp', 'qn732_chp', 'qn734_chp', 'qn1002_hhw', 'qn1005_hhw',
        'shop_village', 'childid']
        self._training_set_indices = None
        self._original_variable_names = None

    def _read_data(self):
        # Open connection to database
        conn = psycopg2.connect("dbname=lg user=postgres")
        cur = conn.cursor()

        # Data interface
        # query = 'SELECT * FROM join_tables_tmp;'
        query = 'SELECT * FROM features;'

        # Load data into a pandas data frame
        self._data = pd.read_sql(query, conn)

        # Store original variable names
        self._original_variable_names = self._data.columns.values.tolist()

        # Close connection
        conn.close()

    def _create_training_set_indices(self):
        self._training_set_indices = self._data.sample(frac=self._train_test_split_frac, random_state=42).index.values

    def _generate_indices(self, data_set):
        if data_set == 'training':
            return self._training_set_indices
        else:
            return np.setdiff1d(self._data.index.values, self._training_set_indices)

    def _string_to_integer(self, feature):
        # First float cast to handle 1.0 and 0.0 cases
        self._data[feature] = self._data[feature].astype(float).astype(int)

    def _string_to_numeric(self, feature):
        self._data[feature] = self._data[feature].map(lambda x: float(x) if x else None)

    def _impute_mean(self, feature):
        self._data[feature] = self._data[feature].fillna(np.mean(self._data[feature]))

    def _dummify(self, column):
        # print '{} is your baseline'.format(sorted(df[column].unique())[-1])
        dummy = pd.get_dummies(self._data[column]).rename(columns=lambda x: column+'_'+str(x).replace(' ', '_')).iloc[:,0:len(self._data[column].unique())]#-1]
        self._data = self._data.drop(column, axis=1)
        self._data = pd.concat([self._data, dummy], axis=1)

    def get_feature_names(self):
        features = self._data.columns.values.tolist()
        features.remove('died')
        features.append('died')
        return features

    def get_original_variable_names(self):
        variables = self._original_variable_names
        variables.remove('died')
        return variables

    def clean(self, data_set='training'):
        self._read_data()
        self._create_training_set_indices()

        for feature in self._integer_features:
            self._string_to_integer(feature)

        for feature in self._categorical_features:
            self._dummify(feature)

        for feature in self._numeric_features:
            self._string_to_numeric(feature)
            self._impute_mean(feature)

        df = self._data.copy()
        y = np.array(df.pop('died'))
        X = df.values
        indices = self._generate_indices(data_set)
        return X[indices], y[indices]
