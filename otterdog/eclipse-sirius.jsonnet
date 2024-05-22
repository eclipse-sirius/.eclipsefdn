local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-sirius') {
  settings+: {
    blog: "https://eclipse.dev/sirius",
    dependabot_alerts_enabled_for_new_repositories: false,
    dependabot_security_updates_enabled_for_new_repositories: false,
    dependency_graph_enabled_for_new_repositories: false,
    description: "Sirius is a framework for building graphical modelers for dedicated DSLs, either for the desktop or the web.",
    name: "Eclipse Sirius",
    packages_containers_internal: false,
    twitter_username: "EclipseSirius",
    web_commit_signoff_required: false,
    workflows+: {
      default_workflow_permissions: "write",
    },
  },
  webhooks+: [
    orgs.newOrgWebhook('https://ci.eclipse.org/sirius/github-webhook/') {
      content_type: "json",
      events+: [
        "pull_request",
        "push"
      ],
    },
  ],
  _repositories+:: [
    orgs.newRepo('.github') {
      allow_merge_commit: true,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      web_commit_signoff_required: false,
      workflows+: {
        actions_can_approve_pull_request_reviews: false,
      },
      branch_protection_rules: [
        orgs.newBranchProtectionRule('master') {
          required_approving_review_count: null,
          requires_linear_history: true,
          requires_pull_request: false,
        },
      ],
    },
    orgs.newRepo('sirius-desktop') {
      allow_squash_merge: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      description: "Sirius Desktop: desktop-based graphical modelers for dedicated DSLs",
      has_discussions: true,
      has_projects: false,
      has_wiki: false,
      homepage: "https://eclipse.dev/sirius/",
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        orgs.newBranchProtectionRule('master') {
          required_approving_review_count: 0,
          requires_linear_history: true,
          requires_strict_status_checks: true,
        },
      ],
    },
    orgs.newRepo('sirius-emf-json') {
      allow_squash_merge: false,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_alerts_enabled: false,
      description: "JSON-based EMF Resource implementation - part of Eclipse Sirius",
      homepage: "https://eclipse.dev/sirius/sirius-web.html",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
    },
    orgs.newRepo('sirius-legacy') {
      archived: true,
      default_branch: "master",
      description: "Sirius Legacy: legacy (unmaintained) components from Sirius Desktop",
      has_projects: false,
      has_wiki: false,
      homepage: "https://www.eclipse.org/sirius/",
      workflows+: {
        default_workflow_permissions: "write",
      },
      branch_protection_rules: [
        orgs.newBranchProtectionRule('master') {
          required_approving_review_count: 0,
          requires_linear_history: true,
          requires_strict_status_checks: true,
        },
      ],
    },
    orgs.newRepo('sirius-specs') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      description: "Specifications for changes to Eclipse Sirius",
      homepage: "",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
    },
    orgs.newRepo('sirius-web') {
      allow_squash_merge: false,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Reusable frontend and backend components for Sirius Web",
      has_discussions: true,
      homepage: "https://eclipse.dev/sirius/sirius-web.html",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      secrets: [
        orgs.newRepoSecret('STAGING_AWS_ACCESS_KEY_ID') {
          value: "********",
        },
        orgs.newRepoSecret('STAGING_AWS_SECRET_ACCESS_KEY') {
          value: "********",
        },
      ],
      branch_protection_rules: [
        orgs.newBranchProtectionRule('master') {
          required_approving_review_count: 1,
          requires_linear_history: true,
          requires_strict_status_checks: true,
        },
      ],
    },
    orgs.newRepo('sirius-website') {
      allow_squash_merge: false,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      description: "Eclipse Sirius website",
      has_projects: false,
      has_wiki: false,
      homepage: "https://eclipse.dev/sirius",
      web_commit_signoff_required: false,
      workflows+: {
        enabled: false,
      },
    },
    orgs.newRepo('sirius-website-sources') {
      allow_squash_merge: false,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      description: "Sources of the Eclipse Sirius website",
      has_projects: false,
      has_wiki: false,
      homepage: "https://eclipse.dev/sirius",
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
      secrets: [
        orgs.newRepoSecret('GH_ACTION_TOKEN') {
          value: "pass:bots/modeling.sirius/github.com/api-token",
        },
      ],
    },
  ],
}
