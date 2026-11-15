# Frontend: React, Vite, TypeScript strict, pnpm, TanStack Query, Tailwind.
Start flat in src/. Split into folders, or add a layer, only when concrete code needs it.
- Pure types and functions stay free of React and fetch.
- api.ts does the I/O: the client for the backend /v1 routes, parsed with zod. Components never call fetch; they use TanStack Query hooks over it.
- Components have typed props. Accessible markup. No `any`, no non-null `!`, no `as` casts except `as const`.
- Biome owns lint and format.
