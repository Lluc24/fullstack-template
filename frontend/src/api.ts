import { useQuery } from "@tanstack/react-query";
import { z } from "zod";

const healthResponse = z.object({ status: z.literal("ok") });

export type Health = z.infer<typeof healthResponse>;

async function fetchHealth(): Promise<Health> {
  const response = await fetch("/v1/health");
  if (!response.ok) {
    throw new Error(`GET /v1/health answered ${response.status}`);
  }
  return healthResponse.parse(await response.json());
}

export function useHealth() {
  return useQuery({ queryKey: ["health"], queryFn: fetchHealth });
}
