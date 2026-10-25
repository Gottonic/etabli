# Établi

Mes projets, semaine par semaine : liste par priorité, planning, boîte « en vrac ».

- App : https://gottonic.github.io/etabli/
- Données : Supabase (une table `rows`, chacun ne voit que ses lignes)
- Fonctionne hors ligne : les changements partent dès que le réseau revient.

## Mise en route (une seule fois)

### 1. Créer la base
Supabase → ton projet `etabli` → **SQL Editor** → **New query** → coller le contenu de `supabase/schema.sql` → **Run**.

### 2. Créer ton compte
Supabase → **Authentication** → **Users** → **Add user** → **Create new user** :
adresse e-mail + mot de passe, cocher **Auto Confirm User**.

Puis fermer la porte aux inconnus : **Authentication** → **Sign In / Providers** →
désactiver **Allow new users to sign up**.

### 3. Activer le site
GitHub → dépôt `etabli` → **Settings** → **Pages** → Source : **Deploy from a branch**,
branche `main`, dossier `/ (root)` → **Save**. Le site est en ligne après une minute environ.

## Installer l'app

- **Fairphone / Dumber Mini** : ouvrir l'adresse dans le navigateur → menu → **Installer** ou
  **Ajouter à l'écran d'accueil**. L'app s'ouvre ensuite en plein écran, sans barre.
- **Ubuntu** : dans Chromium, Brave ou Vivaldi → icône d'installation dans la barre d'adresse.
  Dans Firefox : un onglet épinglé.

Se connecter une fois par appareil.

## Bon à savoir

- Le petit symbole à côté du numéro de semaine indique l'état : ✓ tout est enregistré,
  ↻ envoi en cours, « hors ligne », ⚠ problème (toucher pour les détails).
- Toucher ce symbole permet aussi d'**exporter toutes tes données** dans un fichier.
- GitHub envoie un signal à la base deux fois par semaine pour qu'elle ne se mette pas en veille
  (`.github/workflows/garder-eveille.yml`). GitHub arrête ces signaux après 60 jours sans aucune
  modification du dépôt : dans ce cas, Actions → « Garder Supabase éveillé » → **Enable workflow**.
- Les clés présentes dans le code (adresse du projet, clé « publishable ») sont faites pour être publiques.
  Ne jamais mettre ici la clé « secret / service_role » ni le mot de passe de la base.
