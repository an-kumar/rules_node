load("@bazel_tools//tools/build_defs/pkg:pkg.bzl", "pkg_tar")

def _node_bundle_impl(ctx):
    return struct(
        files = depset(ctx.attr.node_binary.node_binary.files),
    )

_node_bundle = rule(
    _node_bundle_impl,
    attrs = {
        'node_binary': attr.label(
            providers = ['node_binary'],
            mandatory = True,
        ),
    },
)


def node_bundle(name = None,
                node_binary = None,
                extension = None,
                visibility = None,
                **kwargs):

    _node_bundle(
        name = name,
        node_binary = node_binary
    )
    
    pkg_tar(
        name = node_binary + '_deploy',
        extension = extension,
        package_dir = name,
        srcs = [name],
        visibility = visibility,
        strip_prefix = './',
    )
