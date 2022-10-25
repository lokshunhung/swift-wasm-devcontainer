# https://github.com/microsoft/vscode-dev-containers/blob/2d7848342c532515ae710c675ceedeac5b403d80/containers/swift/.devcontainer/Dockerfile

ARG VARIANT=5.5-focal
FROM swift:${VARIANT}

# [Option] Install zsh
ARG INSTALL_ZSH="true"
# [Option] Upgrade OS packages to their latest versions
ARG UPGRADE_PACKAGES="false"

# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
COPY library-scripts/common-debian.sh /tmp/library-scripts/
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && /bin/bash /tmp/library-scripts/common-debian.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true" \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/library-scripts

# [Choice] Node.js version: none, lts/*, 16, 14, 12, 10
ARG NODE_VERSION="none"
ENV NVM_DIR=/usr/local/share/nvm
ENV NVM_SYMLINK_CURRENT=true \
    PATH=${NVM_DIR}/current/bin:${PATH}
COPY library-scripts/node-debian.sh /tmp/library-scripts/
RUN bash /tmp/library-scripts/node-debian.sh "${NVM_DIR}" "${NODE_VERSION}" "${USERNAME}" \
    && rm -rf /var/lib/apt/lists/* /tmp/library-scripts

# [Optional] Uncomment this section to install additional OS packages you may want.
ARG SWIFT_WASM_TAG="swift-wasm-5.7.1-RELEASE"
ARG SWIFT_WASM_PLATFORM_SUFFIX="ubuntu20.04_x86_64.tar.gz"
ENV SWIFT_WASM_ROOT="/swift-wasm/usr/bin"
RUN export SWIFT_BIN_URL="https://github.com/swiftwasm/swift/releases/download/$SWIFT_WASM_TAG/$SWIFT_WASM_TAG-$SWIFT_WASM_PLATFORM_SUFFIX" \
    && mkdir -p /swift-wasm \
    && curl -fsSL "$SWIFT_BIN_URL" -o /swift-wasm/swift.tar.gz \
    && tar -xzf /swift-wasm/swift.tar.gz --directory /swift-wasm --strip-components=1 \
    && chmod -R o+r "$SWIFT_WASM_ROOT" \
    && rm -rf /swift-wasm/swift.tar.gz

COPY library-scripts/get-wasmer-io.sh /tmp/library-scripts/
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends libtinfo5 wabt \
    && export WASMER_DIR=/usr/local/share/wasmer \
    && /bin/sh /tmp/library-scripts/get-wasmer-io.sh \
    && rm -rf /tmp/library-scripts \
    && command printf "# Wasmer config\nexport WASMER_DIR=\"$WASMER_DIR\"\nexport WASMER_CACHE_DIR=\"\$WASMER_DIR/cache\"\nexport PATH=\"\$WASMER_DIR/bin:\$PATH:\$WASMER_DIR/globals/wapm_packages/.bin\"\n" >> /etc/bash.bashrc \
    && ([ -f "/etc/zsh/zshrc" ] && command printf "# Wasmer config\nexport WASMER_DIR=\"$WASMER_DIR\"\nexport WASMER_CACHE_DIR=\"\$WASMER_DIR/cache\"\nexport PATH=\"\$WASMER_DIR/bin:\$PATH:\$WASMER_DIR/globals/wapm_packages/.bin\"\n" >> /etc/zsh/zshrc || exit 0)

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1
