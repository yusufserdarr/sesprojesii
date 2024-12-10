import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report

# features.csv dosyasını yükle
data = pd.read_csv('features.csv')

# Özellikler ve etiketler
X = data.drop(columns=['FileName', 'label'])  # Özellikler (FileName ve label dışında)
y = data['label']  # Etiketler

# Veriyi eğitim ve test olarak ayır
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

# Modeli oluştur ve eğit
model = LogisticRegression(max_iter=1000)
model.fit(X_train, y_train)

# Modeli test et
y_pred = model.predict(X_test)

# Sonuçları yazdır
print(classification_report(y_test, y_pred))
