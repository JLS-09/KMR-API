import Fastify from "fastify";
import scheduleGitActions from "./git/gitActions";


const fastify = Fastify({
  logger: {
    transport: {
      target: "pino-pretty",
    },
  },
});

async function main() {
  await fastify.listen({
    port: 3000,
    host: "0.0.0.0"
  })

  scheduleGitActions();
}

["SIGINT", "SIGTERM"].forEach((signal) => {
  process.on(signal, async () => {
    await fastify.close()

    process.exit(0);
  })
})

main();
