const { test, expect } = require('@playwright/test');

async function loginAsAdmin(page) {
  await page.goto('index.php', { waitUntil: 'domcontentloaded' });
  await page.fill('#usuario', 'admin@vota.com');
  await page.fill('#password', 'password');
  await page.getByRole('button', { name: 'Iniciar Sesión' }).click();
  await expect(page).toHaveURL(/dashboard\.php$/);
}

test('unauthenticated users are redirected to index.php', async ({ page }) => {
  await page.goto('dashboard.php', { waitUntil: 'domcontentloaded' });
  await expect(page).toHaveURL(/index\.php$/);
  await expect(page.getByRole('heading', { name: 'Vota & Opina' })).toBeVisible();
});

test('admin can access dashboard.php and usuarios.php', async ({ page }) => {
  await loginAsAdmin(page);
  await expect(page.getByRole('heading', { name: 'Panel Principal' })).toBeVisible();

  await page.goto('usuarios.php', { waitUntil: 'domcontentloaded' });
  await expect(page).toHaveURL(/usuarios\.php$/);
  await expect(page.getByRole('heading', { name: 'Gestión de Usuarios' })).toBeVisible();
});
