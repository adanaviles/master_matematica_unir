import pandas as pd
from sklearn.datasets import make_classification


class DatasetGenerator:
    def __init__(self,
                 dni: str):
        self.dni = dni
        self._check_dni()
        self._prepare_dni()
        self.dataset = None

    def _check_dni(self):
        """
        Check if DNI is well defined
        Returns: The error if is not

        """
        if not isinstance(self.dni, str):
            raise TypeError('DNI is not an string')
        if not self.dni.isnumeric():
            raise ValueError('DNI has characters that are not numbers')
        if len(self.dni) != 8:
            raise ValueError('DNI has not 8 digits')

    def _prepare_dni(self):
        """
        Change the 0 and 1 to 2
        Returns:

        """
        self.dni.replace('1', '2').replace('0', '2')

    def _create_dataset(self):
        X, y = make_classification(n_samples=200+10*int(self.dni[0]),
                        n_features=10+int(self.dni[1])+int(self.dni[2]),
                        n_informative=10+int(self.dni[1]),
                        shuffle=False,
                        random_state=int(self.dni))
        list_of_features = [
            f'feature_{number}' for number in
            range(0, 10+int(self.dni[1])+int(self.dni[2]))
        ]
        dataset = pd.DataFrame(X, columns=list_of_features)
        dataset['target'] = y
        self.dataset = dataset

    def get_clean_dni(self):
        return self.dni

    def get_dataset(self):
        if self.dataset is None:
            self._create_dataset()
        return self.dataset


if __name__ == '__main__':
    dg = DatasetGenerator(dni='48778094')
    df = dg.get_dataset()