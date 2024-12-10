import os
import librosa
import numpy as np
import pandas as pd

class FeatureExtractor:
    def __init__(self, folder_path):
        self.folder_path = folder_path

    def extract_features(self, file_path):
        try:
            # Ses dosyasını yükle
            y, sr = librosa.load(file_path, sr=None)

            # MFCC (Mel-Frequency Cepstral Coefficients) çıkarma
            mfccs = librosa.feature.mfcc(y=y, sr=sr, n_mfcc=13)
            mfccs_mean = np.mean(mfccs, axis=1)  # Ortalama değerleri al
            mfccs_var = np.var(mfccs, axis=1)    # Varyans değerlerini al

            # Ekstra özellikler (zero crossing rate, spectral centroid)
            zcr = np.mean(librosa.feature.zero_crossing_rate(y))
            spectral_centroid = np.mean(librosa.feature.spectral_centroid(y=y, sr=sr))

            # Özellikleri birleştir
            features = np.concatenate([mfccs_mean, mfccs_var, [zcr, spectral_centroid]])
            return features
        except Exception as e:
            print(f"Error processing {file_path}: {e}")
            return None

    def process_all_files(self):
        feature_list = []
        file_names = []
        for file_name in os.listdir(self.folder_path):
            if file_name.endswith('.wav'):
                file_path = os.path.join(self.folder_path, file_name)
                print(f"Processing {file_path}...")
                features = self.extract_features(file_path)
                if features is not None:
                    feature_list.append(features)
                    file_names.append(file_name)

        # Pandas DataFrame oluştur
        df = pd.DataFrame(feature_list)
        df['FileName'] = file_names
        return df

# Kullanım
if __name__ == "__main__":
    folder_path = "voices"  # Ses dosyalarının bulunduğu klasör
    extractor = FeatureExtractor(folder_path)
    features_df = extractor.process_all_files()

    # CSV'ye yaz
    features_df.to_csv("features.csv", index=False)
    print("Özellikler 'features.csv' dosyasına yazıldı.")
