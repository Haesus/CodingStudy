// 깃허브의 Labels을 자동으로 적용시키는 스크립트
const githubLabelSync = require(`github-label-sync`);
const fs = require('fs');

const accessToken = 'YourToken';
const labelsPath = 'labels.json';
const repo = 'UserName/RepoName';

// Label의 내용 변경
fs.readFile(labelsPath, 'utf8', (err, data) => {
    if (err) {
        console.error('Error reading labels.json:', err);
        return;
    }

    // JSON 문자열을 라벨 객체 배열로 파싱
    const labels = JSON.parse(data);

    githubLabelSync({
        accessToken: accessToken,
        repo: repo,
        labels: labels,
        dryRun: false
    }).then(diff => {
        console.log('라벨이 성공적으로 동기화되었습니다:', diff);
    }).catch(error => {
        console.error('라벨 동기화 중 오류가 발생했습니다:', error);
    });
});

// 라벨 정보 읽어오기
githubLabelSync({
    accessToken: accessToken,
    repo: repo,
    labels: [],
    dryRun: true,
}).then(diff => {
    console.log(diff);
});