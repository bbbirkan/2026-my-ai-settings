# Birkan GitHub SSH New Repo Push Recipe

Durable setup on Contabo VDS:

- SSH private key: `/root/.ssh/trade_push`
- Public key is registered for `github.com/bbbirkan`
- User expects GitHub push/pull to proceed autonomously.

## Problem Pattern

New repo creation may succeed through GitHub API/PAT, but push can fail if the local `origin` was left as HTTPS:

```text
remote: Permission to bbbirkan/<repo>.git denied to bbbirkan.
fatal: unable to access 'https://github.com/bbbirkan/<repo>.git/': The requested URL returned error: 403
```

Do not ask the user for another token. Switch the remote to SSH and force the known key.

## Recipe

```bash
repo=<repo-name>
workdir=/path/to/local/repo

ssh-keyscan -t ed25519 github.com >> /root/.ssh/known_hosts 2>/dev/null || true
ssh -i /root/.ssh/trade_push -o IdentitiesOnly=yes -o StrictHostKeyChecking=accept-new -T git@github.com || true

git -C "$workdir" remote remove origin >/dev/null 2>&1 || true
git -C "$workdir" remote add origin "git@github.com:bbbirkan/${repo}.git"
git -C "$workdir" branch -M main
GIT_SSH_COMMAND="ssh -i /root/.ssh/trade_push -o IdentitiesOnly=yes -o StrictHostKeyChecking=accept-new" \
  git -C "$workdir" push -u origin main
```

## Verification

```bash
git -C "$workdir" remote -v
git -C "$workdir" status -sb
```

Expected remote:

```text
origin  git@github.com:bbbirkan/<repo>.git (fetch)
origin  git@github.com:bbbirkan/<repo>.git (push)
```

## Notes

- `gh auth status` may be unauthenticated; that does not matter for SSH push.
- Fine-grained PATs can create repos but still fail pushes if repo access/contents write scope is missing.
- SSH is the preferred push path on this server.

🤖 *Bu doküman Hermes Agent tarafından oluşturuldu*
