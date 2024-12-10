import os
import librosa
import librosa.display
import matplotlib.pyplot as plt
import numpy as np

# Ses dosyalarının bulunduğu klasör
folder_path = 'voices'  # Ses dosyalarının bulunduğu klasörün adı

# Klasördeki tüm .wav dosyalarını al
audio_files = [f for f in os.listdir(folder_path) if f.endswith('.wav')]

# Grafikleri alt alta göstermek için figure oluştur
plt.figure(figsize=(10, 12))  # Tüm grafiklerin boyutunu ayarla

# Her ses dosyasını sırayla işle
for idx, audio_file in enumerate(audio_files):
    audio_path = os.path.join(folder_path, audio_file)
    
    # Ses dosyasını yükle
    y, sr = librosa.load(audio_path)

    # Alt alta yerleştirilecek grafikler için subplot kullan
    plt.subplot(len(audio_files), 2, idx * 2 + 1)  # Dalga formu için
    librosa.display.waveshow(y, sr=sr)
    plt.title(f'Waveform - {audio_file}')  # Başlık
    plt.xlabel('Time (samples)')  # X ekseni etiketleri (Zaman)
    plt.ylabel('Amplitude')  # Y ekseni etiketleri (Genlik)

    # Frekans grafiğini çizmek için
    D = librosa.amplitude_to_db(np.abs(librosa.stft(y)), ref=np.max)  # STFT dönüşümü ve dB'ye dönüştürme
    plt.subplot(len(audio_files), 2, idx * 2 + 2)  # Frekans grafiği için
    librosa.display.specshow(D, sr=sr, x_axis='time', y_axis='log')
    plt.title(f'Spectrogram - {audio_file}')  # Başlık
    plt.xlabel('Time (s)')  # X ekseni etiketleri (Zaman)
    plt.ylabel('Frequency (Hz)')  # Y ekseni etiketleri (Frekans)

# Tüm grafikleri aynı anda göster
plt.tight_layout()  # Grafikleri düzgün hizalamak için
plt.show()
