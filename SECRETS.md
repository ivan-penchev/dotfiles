# Sops Secrets Management on Windows/WSL

To store secrets in the repository a very easy way is to use SOPS: Secrets OPerationS.
There many ways to encrypt the secrets, I would be using age keyfile. Here is an example workflow to add your `gemini_api_key` variable:

## 1. Generate an Age Key (If you haven't)

Run this inside WSL:

```bash
mkdir -p ~/.config/sops/age
age-keygen -o ~/.config/sops/age/keys.txt
```

* Copy the public key (it starts with `age1...`). You will need it for the `.sops.yaml` configuration.

## 2. Configure .sops.yaml

Create a `.sops.yaml` file in the root of your repo to tell sops which keys to use for which files.

```yaml
# .sops.yaml
creation_rules:
  - path_regex: secrets/.*\.yaml$
    key_groups:
      - age:
          - "age1..." # REPLACE THIS WITH YOUR PUBLIC KEY
```

## 3. Create/Edit the Secrets File

Now, use sops to create the encrypted file. Run this in WSL:

```bash
sops secrets/secrets.yaml
```

This will open your `$EDITOR` (vim/nano). Add the secret like this:

```yaml
gemini_api_key: "your_actual_api_key_starts_with_AIza..."
```

Save and exit. Sops will encrypt the file automatically.

## 4. Git Add

Because you are using Flakes, Nix only sees files that are known to git.

```bash
git add .sops.yaml secrets/secrets.yaml
```

## 5. Rebuild

Now you can run the rebuild command. Nix will see the encrypted file, use your private key (at `~/.config/sops/age/keys.txt`) to decrypt it, and render the aichat config file.

---

## Windows Specific Instructions

**To create/edit the file on your Windows machine:**

Depending on where you stored your age key, set the environment variable and editor, then run sops.

```powershell
$env:SOPS_AGE_KEY_FILE = "C:\Users\ivan\.config\sops\age\keys.txt"
$env:SOPS_EDITOR = "Notepad"
sops .\secrets\secrets.yaml
```

Once you have done this, run the rebuild command again in WSL.
