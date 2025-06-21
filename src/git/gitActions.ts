import { existsSync } from "node:fs";
import { simpleGit, SimpleGit, CleanOptions } from 'simple-git';
import { scheduleJob } from "node-schedule";

const git: SimpleGit = simpleGit().clean(CleanOptions.FORCE);

async function performGitActions() {
  try {
    if (!existsSync("./public/ckan-meta")) {
      console.log('Cloning repository...');
      await git.clone("https://github.com/KSP-CKAN/CKAN-meta.git", "./public/ckan-meta/");
      console.log(`Repository cloned successfully`);
    } else {
      console.log("directory already exists, performing pull");
      await git.pull("./public/ckan-meta");
      console.log(`Pulling succesfull`);
    }
  } catch (error) {
      console.error('Error cloning repository:', error.message);
  }
}

export default function scheduleGitActions() {
  scheduleJob('*/5 * * * *', performGitActions);
}
