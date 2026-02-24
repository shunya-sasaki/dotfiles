# TypeScript Style Guide

## Naming Rules

### Functions and Classes

- Function: `camelCase`
- Function component: `PascalCase`
- Interface: `PascalCase`
- Hooks: `PascalCase`

### Directories

- Page directory: `kebab-case`
- Component: `PascalCase`
- Other: `lowercase`

### Files

- Page file: `page.tsx`
- Hooks file: `useCamelCase.tsx`
- Component file: `PascalCase.tsx`
- Interface file: `PascalCase.ts`
- Type file: `PascalCase.ts`

### Common Folder Conventions

- `components` — Reusable components that can be used across different pages or features.
- `hooks` — Custom React hooks that encapsulate reusable logic.
- `lib` — Third-party integrations and low-level helper libraries.
- `utils` — General-purpose utility and helper functions.
- `styles` — Global styles, CSS/SCSS files, and theme definitions.
- `types` — Shared TypeScript type and interface definitions.
- `stores` — State management stores (e.g., Zustand, Redux).
- `constants` — Application-wide constant values.
- `public` — Static assets served publicly (images, fonts, icons, etc.).
- `api` — API route handlers or API client functions.
- `context` — React context providers and consumers.
- `services` — Business logic and external service integrations.
- `middleware` — Middleware functions for request/response handling.

## Function Definitions

Use arrow functions for defining functions, as they provide a more concise syntax.

## State Management

- Use `useState` for client state management in React components.
- Use tanstack query for server state management to handle data fetching and caching.
- Use Zustand for global state management to manage application-wide state in a simple and efficient way.

## Linter

Use `biome` for linting TypeScript code to ensure code quality and consistency.

## Formatter

Use `biome` for formatting TypeScript code to maintain a consistent code style across the project.
