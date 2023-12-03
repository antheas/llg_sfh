# AMD Sensor Fusion Hub Custom DKMS
Patches the legion go sfh driver to sample the gyroscope at 100hz.

Install with:
```bash
sudo rmmod amd_sfh

sudo git clone https://github.com/antheas/llg_sfh /usr/src/amd_sfh_custom-0.0.1
cd /usr/src/amd_sfh_custom-0.0.1
sudo make dev
```