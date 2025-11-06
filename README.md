# Smoothie Move — MFR de Gionges (version complète)

Ce dépôt contient la **version front-end** (React + Vite) du projet *Smoothie Move*.
Le backend utilise **Supabase** (Postgres, Auth, Storage).

> ⚠️ Ce package contient le front-end et les scripts/SQL pour initialiser la base Supabase. Il ne contient pas le projet Supabase lui-même — il faut créer un projet Supabase et configurer les variables d'environnement.

## Contenu
- `src/` : code React
- `logo.png` : logo de la MFR
- `supabase.sql` : commandes SQL pour créer les tables et la fonction RPC `credit_points`
- `import_students.csv` : exemple de fichier pour importer les élèves
- `README.md` : ce fichier

## Déploiement (résumé rapide)
1. Crée un compte sur https://supabase.com et crée un nouveau projet.
2. Dans Supabase -> SQL, exécute `supabase.sql` pour créer les tables et la fonction.
3. Crée un **bucket** dans Storage appelé `activity-photos` et rends-le public ou règle les policies selon le README détaillé.
4. Copie l'URL du projet Supabase et la clé `anon` (Project API Settings → Config). Dans le repo, crée un fichier `.env` ou configure les variables sur Vercel/Netlify :
   - `VITE_SUPABASE_URL=...`
   - `VITE_SUPABASE_ANON_KEY=...`
5. (Optionnel) Configurer Strava / Google OAuth : crée les applications côté Strava/Google et ajoute les credentials au projet Supabase (voir section détaillée dans README_full.md).
6. Déployer sur Vercel / Netlify en liant le repo GitHub et en ajoutant les variables d'environnement.

## Fonctionnalités implémentées côté front-end
- Connexion par email (magic link) via Supabase Auth.
- Soumission d'activité (avec photo uploadée dans Supabase Storage).
- Interface admin pour valider/rejeter les activités.
- Classement des élèves (top 10).
- QR code : géré côté admin (création lors de la génération de récompense).

## Fichiers importants à exécuter dans Supabase (supabase.sql)
Voir `supabase.sql` pour les commandes SQL. Elle crée : `users`, `activities`, `points_history`, `qr_tokens`, `challenges` et la fonction `credit_points`.

---

Si tu veux, je peux :
- Générer le **repo complet zippé** prêt à envoyer à un développeur ou à connecter à GitHub (je l'ai déjà préparé dans ce package).
- Écrire un guide pas-à-pas plus détaillé (création du projet Supabase, règles de stockage, policies RLS, configuration OAuth Strava/Google).
- Déployer la version initiale en demo (si tu veux que je le fasse, j'aurai besoin d'accéder à un compte d'hébergement ou d'utiliser un déploiement sur Vercel sous ton compte).