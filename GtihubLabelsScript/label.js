// 깃허브의 Labels을 자동으로 적용시키는 스크립트
const githubLabelSync = require(`github-label-sync`);

githubLabelSync({
    accessToken: `Your Token`,
    repo: `Haesus/SwiftStudy`,
    labels: [],
    dryRun: true,
}).then(diff => {
    console.log(diff);
});