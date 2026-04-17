function awsp
    set -l profile $argv[1]
    set -e argv[1]

    # Check if logged in
    if not aws sts get-caller-identity --profile $profile >/dev/null 2>&1
        echo "Not logged in to AWS profile '$profile'. Logging in..."
        aws login --profile $profile

        if not aws sts get-caller-identity --profile $profile >/dev/null 2>&1
            echo "AWS login failed for profile '$profile'"
            return 1
        end
    end

    # Get credentials without 'export'
    set env_args
    for line in (aws configure export-credentials --profile $profile --format env-no-export)
        set env_args $env_args $line
    end

    # Run command in isolated env
    env $env_args $argv
end
