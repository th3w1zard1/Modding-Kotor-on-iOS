---
lang: en
---

# Modding *Knights of the Old Republic* on iOS

A practical guide to obtaining a **decrypted IPA**, preparing it for **TSLPatcher** (and related tools), and **sideloading** a modded build back to an iPhone or iPad. *KotOR* and *The Sith Lords* (often called **K1** and **K2**) are distributed on iOS as **IPA** files—standard iOS app packages you can back up, inspect on a computer, and (once decrypted) modify like a PC game folder.

> **On this page:** [Getting the IPA](#getting-a-decrypted-ipa) · [ipatool path](#using-ipatool) · [Decrypt helper files](#merging-decrypted-assets) · [Modding](#modding-your-decrypted-ipa) · [Sideloadly](#sideloadly) · [Troubleshooting](#troubleshooting-tips)

## Getting a decrypted IPA

You need a copy of the game in **decrypted** form. Two common routes:

1. **On-device decryption** (AppDump2 + TrollStore) — when your device can run those tools.
2. **Download with ipatool** (PC/Mac) — when you cannot or prefer not to use the first method; you then **merge in** decrypted files from a separate download (see [below](#merging-decrypted-assets)).

### What you will use

- **[Sideloadly](https://sideloadly.io/)** — for installing the finished IPA to your device from a PC (required later; install it on your computer now).
- **[AppDump2](https://onejailbreak.com/blog/appdump2/)** and **[TrollStore](https://trollstore.app/)** — on **iOS** only, for dumping/decrypting an installed app’s IPA, if your device supports them.
- A **file manager** or transfer method to move the IPA from the device to your PC.

### Steps (AppDump2 + TrollStore)

1. Install **Sideloadly** on your computer from the link above.
2. On your iOS device, set up **AppDump2** and **TrollStore** using the official instructions for each.
3. Use **AppDump2** together with **TrollStore** to produce a **decrypted IPA** of *KotOR* (K1) or *The Sith Lords* (K2).
4. Send that IPA to your PC with the file manager or method you prefer.

If that completes successfully, you can skip the ipatool section and go straight to [Modding your decrypted IPA](#modding-your-decrypted-ipa).

---

## Using `ipatool`

If you **cannot** install **AppDump2** or **TrollStore** (or they fail on your device), you can download an encrypted copy of the app from Apple’s servers with **[ipatool](https://github.com/majd/ipatool)**. Those downloads are **not** fully usable for modding until you add decrypted pieces from the MEGA links in [Merging decrypted assets](#merging-decrypted-assets).

### Install and sign in

Install **ipatool** on your PC or Mac and follow the project’s README. Sign in to your Apple account (the same one that **owns** the App Store purchase of the game).

**Example** (replace the placeholders with *your* email and password—**do not** type the angle brackets):

```text
ipatool auth login --email your@email.com --password your-secure-password
```

**Security notes:**

- Your password is sensitive. Prefer running this on a **trusted, private** machine, and be aware that shells often **log command history**. Consider the tool’s documentation for **environment variables** or other safer patterns if available.
- You must **own the game** on the Apple ID you use. Piracy is not supported; this guide assumes a legitimate App Store copy.

### Download the game

Use `ipatool download` with the correct **bundle ID**:

| Game | Bundle ID |
|------|-----------|
| *KotOR* (K1) | `com.aspyr.kotor.ios` |
| *The Sith Lords* (K2) | `com.aspyr.kotor2.ios` |

**Examples:**

```text
ipatool download -b com.aspyr.kotor.ios
ipatool download -b com.aspyr.kotor2.ios
```

### If the download “finishes” with a file-in-use or `.tmp` error

`ipatool` may report that a temporary file could not be closed. In the same folder as `ipatool.exe` (on Windows), look for a file like **`Something.ipa.tmp`**. **Rename** it and remove the **`.tmp`** extension so the file ends in **`.ipa`**. You should then have a valid IPA archive to extract.

If you use only this **ipatool** route, you **still need** the extra decrypted material from the next section before modding and sideloading will work as intended.

---

## Merging decrypted assets

If you used **ipatool**, obtain and merge the following **decrypted file packs** (hosted off-site; links may change if the uploader updates them—check community threads if a link is dead):

- **K1 (KotOR):** [MEGA – K1 decrypted pack](https://mega.nz/file/4GBRWaxK#yHQwJAcrgwp47S3BA-SVbub2cugtVO_VzrkbOR5WDuI)  
- **K2 (The Sith Lords):** [MEGA – K2 decrypted pack](https://mega.nz/file/BORCTbLL#JdLVserxTwD44tfE3K9KscoIArrC5Qg4WMoPGDCmYvE)  

**Merge steps (high level):**

1. **Extract** the IPA you got from `ipatool` with a tool like **7-Zip** (Windows) or an equivalent archive tool.
2. Inside the extracted app bundle, **delete** any folders named **`SC_Info`** (there are usually at least two; you may see three). These relate to app encryption; removing them is part of the usual workflow.
3. **Extract** the MEGA download for your game and **copy** its contents **into** the same extracted IPA tree, **overwriting** when prompted.  
4. If you are **not** asked to overwrite anything, double-check that you are merging into the **correct** inner app folder (the structure should mirror a normal *KotOR* install layout, e.g. `Override`, `modules`, and similar for that title).

You should end up with a **decrypted IPA** structure that TSLPatcher and file-based mods can treat like the PC version’s folders, ready for the [modding](#modding-your-decrypted-ipa) and [Sideloadly](#sideloadly) steps.

---

## Modding your decrypted IPA

You now have a **decrypted IPA** (either directly from the device or after ipatool + MEGA merge).

1. **Point TSLPatcher (or your mod’s installer) at the extracted app folder** — the same tree where `Override`, `modules`, and related directories live.  
2. If TSLPatcher insists on a PC-style path, it may look for a **`swkotor.exe`** (or similar) to recognize the game. The usual workaround is to add a **dummy/placeholder file** with that name in the right place so the patcher accepts the directory as a valid *KotOR* root (follow your mod’s or tool’s current instructions; paths differ slightly for K1 vs K2).  
3. **Install mods** in the standard way: **`Override`**, modules, and other folders as each mod’s readme specifies.

### Case-sensitivity on iOS

iOS’s filesystem is **case-sensitive** in a way that often differs from Windows. A **case-sensitivity fix** step is **required** for many mods, or you may get **crashes (e.g. “New game” → immediate exit)** or missing assets.

- Run the fix only inside the real **content** folders, for example: **`modules`**, **`Override`**, **`streamwaves`**, **`streamsounds`**, **`streamvoice`**, **`rims`**, or **`lips`**, as your tool describes.  
- **Do not** run a blanket lowercasing or rename pass on the **top level of the whole IPA**—only these game-data locations.

### Repack the IPA (zip, not a single nested folder)

When the mods and case fix are done:

1. **Zip the contents** of the **top level** of your modified app payload so the archive opens **directly** to folders and files, **not** to a single parent folder with everything hidden inside.  
2. The usual mistake is creating **`MyApp/MyGame/Override/...`** as the only path inside the zip. Instead, the zip root should show **`Override`**, **`modules`**, and friends **at the top of the archive**, matching how the unzipped IPA looked.  
3. After zipping, rename the archive to **`.ipa`** if your tool expects that extension.

Continue to [Sideloadly](#sideloadly).

---

## Sideloadly

Install the modded build on your device:

1. Open **Sideloadly** and choose your **`.ipa`**.  
2. Open **Advanced options** and review:
   - **Signing mode:** **Apple ID sideload** (as documented; other modes are untested in this guide).  
   - **Enable file sharing** — useful for later file access / tutorials.  
   - **Remove limitation on supported devices** — if you hit artificial compatibility blocks.  
   - **Try to support older iOS versions** — can help on hardware the App Store labels “incompatible” even when the app runs.  
3. Connect the device, select it in Sideloadly (**iDevice**), open the **log viewer** (icon with two arrows), then press **Start**.

**Expect a long install.** The transfer and signing process can take **many minutes**. It is normal to wait a while; avoid unplugging the device mid-run unless a guide tells you to recover from a specific error.

### Sideloadly error: `LOCKDOWN_E_MUX_ERROR`

You may see log lines like:

```text
Got error: Call to lockdownd_start_service failed: LOCKDOWN_E_MUX_ERROR. IPA file exists, retrying
FAILED: Call to lockdownd_start_service failed: LOCKDOWN_E_MUX_ERROR
```

- **Free space:** Many failures come from the device not having **enough free space**. As a **rule of thumb**, try to keep at least **twice the IPA file size** free (e.g. 10 GB free for a ~5 GB package).  
- **Connection:** Unplugging/re-plugging the cable or **restarting Sideloadly** can clear transient USB/lockdownd issues.  
- **Patience:** The process **retries**; if it is still progressing, let it run.

When the log shows **100%** successfully, the sideloaded build should be on your device.

### After a successful install

- **7-day (free) signing:** On a free Apple ID, you typically must **re-sign** about every **7 days** unless you have a **paid Apple Developer** membership. This is an Apple platform rule, not a Sideloadly quirk. Re-sideload periodically to refresh the signature.  
- **“New game” crash:** If the game **crashes immediately** when starting a new game, the usual cause is **skipped or incorrect case-sensitivity fixes** — return to the PC, fix folder/file casing inside the allowed directories, and sideload again.  
- **Known quirk:** Some mod builds (e.g. around **Neocities** mod build content) can show **blaster icon** issues; causes are not fully pinned down in all cases.

---

## Troubleshooting & tips

| Symptom | What to check |
|--------|----------------|
| ipatool login fails | Apple ID, password, 2FA flow per ipatool docs; region/account issues. |
| No “overwrite” when merging MEGA files | Wrong folder; compare against an unzipped K1/K2 app layout. |
| TSLPatcher won’t accept path | Dummy `swkotor.exe` (or K2 equivalent per tool); correct root folder. |
| Build won’t open or crashes in-game | Case-sensitivity; mod load order; vanilla vs modded `modules` conflicts. |
| Sideloadly stuck / mux errors | **Disk space** on the device, cable, USB port, and patience with retries. |

**Legal & ethics:** This guide is for people who **purchased** the iOS app and want to use mods. Do not use these instructions to **pirate** the game or to bypass DRM for copies you do not own.

**Disclaimer:** iOS and tool behavior change over time. Always use the **latest** official **ipatool**, **Sideloadly**, and **TrollStore** / **AppDump2** documentation. Third-party downloads (e.g. MEGA packs) are provided by the community, not this document—verify sources you trust.

---

*For questions or updates, refer to the community maintaining your preferred mod list or installer.*
