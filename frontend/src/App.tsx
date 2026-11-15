import { useHealth } from "./api";

export function App() {
  const health = useHealth();
  return (
    <main className="mx-auto max-w-xl p-8">
      <h1 className="text-2xl font-bold">App</h1>
      <p className="mt-2">
        API: {health.isPending && "checking…"}
        {health.isError && health.error.message}
        {health.isSuccess && health.data.status}
      </p>
    </main>
  );
}
