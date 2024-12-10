import librosa
import matplotlib.pyplot as plt

class PreProcessing:
    def create_histogram(self, audio_file):
        """
        Verilen ses dosyasından histogram oluşturur.
        """
        try:
            # Ses dosyasını yükle
            y, sr = librosa.load(audio_file, sr=None)
            
            # Histogramı oluştur
            plt.figure(figsize=(10, 5))
            plt.hist(y, bins=50, color='blue', alpha=0.7)
            plt.title("Ses Verisi Histogramı")
            plt.xlabel("Amplitüd")
            plt.ylabel("Frekans")
            plt.grid(True)
            plt.show()
        except Exception as e:
            print(f"Hata oluştu: {e}")